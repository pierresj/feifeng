define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'product/product/index',
                    add_url: 'product/product/add',
                    edit_url: 'product/product/edit',
                    del_url: 'product/product/del',
                    multi_url: 'product/product/multi',
                    table: 'product',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'company.company_name', title: __('Company.company_name')},
                        {field: 'product_name', title: __('Product_name')},
                        {field: 'type.type_name', title: __('Type.type_name')},
                        {field: 'product_standard', title: __('Product_standard')},
                        {field: 'product_price', title: __('Product_price'), operate:'BETWEEN'},
                        {field: 'product_images', title: __('Product_images'), formatter: Table.api.formatter.image},
                        {field: 'company.phone', title: __('Company.phone')},
                        {field: 'company.province', title: __('Company.province')},
                        {field: 'company.city', title: __('Company.city')},
                        {field: 'company.district', title: __('Company.district')},
                        {field: 'company.address', title: __('Company.address')},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });
            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});